function addClickToImg() {
    console.error('-----addClickToImg-----');
    var imgs = document.getElementsByTagName("img");
    var urls = new Array();
    for (var i = 0; i < imgs.length; i++) {
        const index = i;
        urls[i] = imgs[i].getAttribute('src');
        imgs[i].onclick = function () {
//           window.imagelistener.openImage(index, urls);
            const result = {
                "index": index,
                "imgs": urls
            }
            window.webkit.messageHandlers.iOSNative.postMessage(result);
        };
    }
}

function reloadImg(url, path) {
//    sendConsole("reloadImg from js, url: " + url + ", path: " + path)
    var imgs = document.querySelectorAll("*[original_src='" + url + "']");
    for (var i=0; i<imgs.length; i++) {
        console.error(imgs[i]);
        imgs[i].setAttribute("src", path);
    }
}

function injectOnLoad(isDark, fontSize) {
//    console.error('js.injectOnLoad');
    decodeEmail();
    document.body.className += isDark ? 'dark ' : ' ';
    document.body.style.fontSize = fontSize + 'px';
}

function sendConsole(message) {
    try {
        webkit.messageHandlers.iOSNative.postMessage("Console:" + message);
    } catch(err) {
        console.log('Something is wrong');
    }
}

window.imgLoaded = false;

function checkAllImgCompleted() {
    setTimeout(function() {
        var imgs = document.querySelectorAll("img")
        var total = imgs.length
        var count = 0
        for(var i = 0; i < total; i++) {
            if (imgs[i].complete) {
                count++
            }
        }
        if (count >= total) {
            window.imgLoaded = true
        } else {
            checkAllImgCompleted()
        }
    }, 100)
}

checkAllImgCompleted()


