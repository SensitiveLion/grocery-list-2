function checkvalue() { 
    var mystring = document.getElementById('item').value; 
    if(!mystring.match(/\S/)) {
        alert ('Empty value is not allowed');
        return false;
    } else {
        return true;
    }
}