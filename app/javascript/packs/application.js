// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= require_tree.

function requestEventPassword(eventId, eventName) {
    console.log(eventId);
    console.log(eventName);
}
  
window.addEventListener("load", () => {
    const links = document.querySelectorAll(
        "a[data-event-id]"
    );
    links.forEach((element) => {
        element.addEventListener("click", (event) => {
            event.preventDefault();
            event.stopPropagation();
    
            const {eventId, eventName} = element.dataset;
            requestEventPassword(eventId, eventName);
        });
    });
});

function filterTable() {
    // Declare variables
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchTableInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("pointsTable");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[1];
        if (td) {
        txtValue = td.textContent || td.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
        }
    }
}