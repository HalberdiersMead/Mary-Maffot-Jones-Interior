//side navbar

const navShowBtn = document.querySelector('.navigationbar-show-btn');
const navHideBtn = document.querySelector('.navigationbar-hide-btn');
const sideNavbar = document.querySelector('.navigationbar-hide-btn');
navShowBtn.addEventListener('click', () =>  {
    sideNavbar.classList.add('side-navigationbar-show');
});

navHideBtn.addEventListener('Click', () => {
    sideNavbar.classList.remove('side-navbar-show');

});

// category
const categoryItems = document.getElementById('category-list-items');
const categoryTogglerBtn = document.querySelector('category-list-items');
categoryTogglerBtn.addEventListener('click', () => {
    categoryItems.classList.toggle('show-category-items');

    if(categoryItems.classList.contains('show-category-items')){
        categoryTogglerBtn.querySelector('i').className = "fas fa-circle-arrow-up";
        
    } else{
        categoryTogglerBtn.querySelector('i').className = "fas fa-circle-arrow-down";

    }
        
    

});