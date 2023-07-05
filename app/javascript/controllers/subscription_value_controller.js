import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // static targets = ["subscriptionField"];

  connect() {
    console.log("Stimulus sub value connected.");
    const subscriptionField = document.getElementById('subscription_field');

    if (!subscriptionField.value) {
      subscriptionField.value = '9.99'; // Set the default value here
    }
  }

  handleChange(event) {
    const selectedValue = event.target.value;
    // this.subscriptionFieldTarget.value = selectedValue;
    console.log("Selected value:", selectedValue);

    const subscriptionField = document.getElementById('subscription_field');
    subscriptionField.value = selectedValue;
  }
}
