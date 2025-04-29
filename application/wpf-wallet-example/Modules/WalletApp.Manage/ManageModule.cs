

using WalletApp.Manage.Views;

namespace WalletApp.Manage
{
    public class ManageModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<ManageView>();
        }
    }

}
