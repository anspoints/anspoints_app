// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import { Modal } from "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= require_tree.

const themeDarkGrey = "#474B4F";
const themeDarkBlue = "#3A546C";
const themeBackgroundColor = "#F0F0F0";
const whiteColor = "#FFF";

function requestEventPassword(eventId, eventName) {
    console.log(eventId);
    console.log(eventName);
}

function handleNavClick(event) {
    console.log(this);
    console.log(this.style.color);
    console.log(this.style.background);
    this.style.color = this.style.color === themeDarkGrey ? whiteColor : themeDarkGrey;
    this.style.backgroundColor = this.style.backgroundColor === themeBackgroundColor ? themeDarkBlue : themeBackgroundColor;
}
  
window.addEventListener("load", () => {
    const links = document.querySelectorAll(
        "a[data-event-id]"
    );
    console.log(links); 
    links.forEach((element) => {
        element.addEventListener("click", (event) => {
            event.preventDefault();
            event.stopPropagation();
    
            const {eventId, eventName} = element.dataset;
            requestEventPassword(eventId, eventName);
        });
    });
    /*
    const navLinks = document.querySelectorAll(
        "a.nav-link"
    );
    navLinks.forEach((element) => {
        element.addEventListener("click", (event) => {
            console.log(element.style.color)
            console.log(element.style.backgroundColor);
            navLinks.forEach(ele => {
                ele.style.color = whiteColor;
                ele.style.backgroundColor = themeBackgroundColor;
            });
            element.style.color = themeDarkGrey;
            element.style.backgroundColor = themeBackgroundColor;
        });
    }); */
});
