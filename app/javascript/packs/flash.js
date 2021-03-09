document.addEventListener('DOMContentLoaded', function() {

  var alert = document.getElementById('alert');
  alert_remove = function(){
    if(alert != null){
    alert.remove()    
  }            
}
  setTimeout(alert_remove,1500);
});