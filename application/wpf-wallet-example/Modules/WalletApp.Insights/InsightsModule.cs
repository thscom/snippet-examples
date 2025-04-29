

using WalletApp.Insights.Views;

namespace WalletApp.Insights
{
    public class InsightsModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<InsightsView>();
        }
    }

}
