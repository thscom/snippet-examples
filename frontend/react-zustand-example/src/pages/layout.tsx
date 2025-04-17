import { Outlet } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useGlobalStore } from "@/features";

export const Layout = () => {
  const { t } = useTranslation();
  const { isOpen } = useGlobalStore();

  return (
    <>
      <header className="w-full h-20">{t("title")}</header>
      <main>
        <aside hidden={!isOpen}>Aside</aside>
        <article>
          <Outlet />
        </article>
      </main>
      <footer>Footer</footer>
    </>
  );
};
