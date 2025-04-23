import { createBrowserRouter } from "react-router-dom";
import { HomePage, Layout } from "@/pages";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    children: [
      { index: true, element: <HomePage /> },
      { path: "about", element: <div>About</div> },
      { path: "contact", element: <div>Contact</div> },
    ],
  },
]);
