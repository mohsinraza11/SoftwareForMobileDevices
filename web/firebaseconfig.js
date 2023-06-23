// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCqWRH2EoRIsAN9Q0x0Y3H5tDgSICOGbBE",
  authDomain: "catapp-e03af.firebaseapp.com",
  projectId: "catapp-e03af",
  storageBucket: "catapp-e03af.appspot.com",
  messagingSenderId: "743616546022",
  appId: "1:743616546022:web:fa8b556309c811817de727",
  measurementId: "G-VWRL5PRGZE"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);