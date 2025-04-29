

using WalletApp.Dashboard.Views;

namespace WalletApp.Dashboard
{
    public class DashboardModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {

        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<DashboardView>();
        }
    }

}
