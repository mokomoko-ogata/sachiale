document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('category-form')){
    function setCategory (){
      document.getElementById('item-meat').style.display = "none";
      document.getElementById('item-vegetable').style.display = "none";
      document.getElementById('item-seafood').style.display = "none";
      document.getElementById('item-seaweed').style.display = "none";
      document.getElementById('item-mushroom').style.display = "none";
      document.getElementById('item-egg').style.display = "none";
      document.getElementById('item-corm').style.display = "none";
      document.getElementById('item-bread').style.display = "none";
      document.getElementById('item-rice').style.display = "none";
      document.getElementById('item-milk').style.display = "none";
      document.getElementById('item-bean').style.display = "none";
      document.getElementById('item-noodle').style.display = "none";
      document.getElementById('item-seasoning').style.display = "none";
    }

      setCategory();
      document.getElementById('item-category').addEventListener('change', function(){
      const category = document.getElementById('item-category').value;
      if (category == 2){
        setCategory();
        document.getElementById('item-meat').style.display = "block";
      }else if(category == 3){
        setCategory();
        document.getElementById('item-vegetable').style.display = "block";
      }else if(category == 4){
        setCategory();
        document.getElementById('item-seafood').style.display = "block";
      }else if(category == 5){
        setCategory();
        document.getElementById('item-seaweed').style.display = "block";
      }else if(category == 6){
        setCategory();
        document.getElementById('item-mushroom').style.display = "block";
      }else if(category == 7){
        setCategory();
        document.getElementById('item-egg').style.display = "block";
      }else if(category == 8){
        setCategory();
        document.getElementById('item-corm').style.display = "block";
      }else if(category == 9){
        setCategory();
        document.getElementById('item-bread').style.display = "block";
      }else if(category == 10){
        setCategory();
        document.getElementById('item-rice').style.display = "block";
      }else if(category == 11){
        setCategory();
        document.getElementById('item-milk').style.display = "block";
      }else if(category == 12){
        setCategory();
        document.getElementById('item-bean').style.display = "block";
      }else if(category == 13){
        setCategory();
        document.getElementById('item-noodle').style.display = "block";
      }else if(category == 14){
        setCategory();
        document.getElementById('item-seasoning').style.display = "block";
      }else if(category == 15){
        setCategory();
      }
    });
  }
}); 