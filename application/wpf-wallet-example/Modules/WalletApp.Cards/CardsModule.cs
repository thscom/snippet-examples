using WalletApp.Cards.Views;

namespace WalletApp.Cards
{
    public class CardsModule : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {

        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<CardsView>();
        }
    }

}
