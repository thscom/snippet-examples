import { Outlet } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useGlobalStore } from "@/features";
import { Button } from "@/components/ui/button";
import { getCurrentWindow } from "@tauri-apps/api/window";
import { X, Minus, Maximize } from "lucide-react";

export const Layout = () => {
  const { t } = useTranslation();
  const { isOpen } = useGlobalStore();
  const appWindow = getCurrentWindow();

  return (
    <div className="flex flex-col h-screen">
      <header data-tauri-drag-region className="w-full p-2 flex flex-row justify-between items-center border-b-2">
        <p className="text-lg font-bold">{t("title")}</p>
        <div className="inline-flex gap-2">
          <Button variant="outline" size="icon" onClick={() => appWindow.minimize()}>
            <Minus />
          </Button>
          <Button variant="outline" size="icon" onClick={() => appWindow.toggleMaximize()}>
            <Maximize />
          </Button>
          <Button variant="outline" size="icon" onClick={async () => appWindow.close()}>
            <X />
          </Button>
        </div>
      </header>
      <main className="flex-1 flex flex-row">
        <aside className="w-64 border-r-2 p-2" hidden={!isOpen}>
          Aside
        </aside>
        <article className="flex-1 p-2">
          <Outlet />
        </article>
      </main>
      <footer className="px-2 py-4 border-t-2">Footer</footer>
    </div>
  );
};
