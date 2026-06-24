import axios from "axios";

export default axios.create({
  baseURL: "http://nginx:80/api",
});


