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

function addShortcutKeys() {
    const links = document.querySelectorAll(
        "a[data-event-id]"
    );
    $(document).on("keyup", function (e) {
        if(e.ctrlKey && e.key == 'z')
            console.log('click on events');
            // links[0].click();
        else if(e.ctrlKey && e.key == 'x')
            console.log('click on points');
            // links[1].click();
        else if(e.ctrlKey && e.key == 'c')
            console.log('click on contacts');
            // links[2].click();
        else if(e.ctrlKey && e.key == 'v')
            console.log('click on admin');
            // links[3].click();
    })
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
    
    addShortcutKeys();
});
