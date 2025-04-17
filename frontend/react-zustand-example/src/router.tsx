import { createBrowserRouter } from "react-router-dom";
import { Layout } from "./pages";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    children: [
      { index: true, element: <div>Home</div> },
      { path: "about", element: <div>About</div> },
      { path: "contact", element: <div>Contact</div> },
    ],
  },
]);
