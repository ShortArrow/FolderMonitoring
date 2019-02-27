document.addEventListener('DOMContentLoaded', function(){
    getJson();
},false);


function getJson() {
    //var xmlhttp = createXMLHttpRequest(); //ãåÉoÅ[ÉWÉáÉìÇÃIEÇ»Ç«Ç…ëŒâûÇ∑ÇÈèÍçá
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                var data = JSON.parse(xmlhttp.responseText);

                var elem = document.getElementById("output_name");
                elem.innerText = data.name;
                var elem = document.getElementById("output_weight");
                elem.innerText = data.weight;
                var elem = document.getElementById("output_height");
                elem.innerText = data.height;
                var elem = document.getElementById("output_price");
                elem.innerText = data.price;
                var elem = document.getElementById("output_memo0");
                elem.innerText = data.memo[0];
                var elem = document.getElementById("output_memo1");
                elem.innerText = data.memo[1];
                var elem = document.getElementById("output_memo2");
                elem.innerText = data.memo[2];

            } else {}
        }
    }
    xmlhttp.open("GET", "./log/data.json");
    xmlhttp.send();
}

function createXMLHttpRequest() {
    if (window.XMLHttpRequest) {
        return new XMLHttpRequest()
    }
    if (window.ActiveXObject) {
        try {
            return new ActiveXObject("Msxml2.XMLHTTP.6.0")
        } catch (e) {}
        try {
            return new ActiveXObject("Msxml2.XMLHTTP.3.0")
        } catch (e) {}
        try {
            return new ActiveXObject("Microsoft.XMLHTTP")
        } catch (e) {}
    }
    return false;
}