import $ from 'jquery';
import "bootstrap-slider/dist/bootstrap-slider.js";
import "bootstrap-slider/dist/css/bootstrap-slider.css";
import 'app'

var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)

$("#alert").click(function () {
    alert("Handler for .click() called.");
});

$('#ex1').slider({
    formatter: function (value) {
        return 'Current value: ' + value;
    }
});
$('#ex2').slider({
    formatter: function (value) {
        return 'Current value: ' + value;
    }
});
