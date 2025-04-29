using System.Configuration;
using System.Data;
using System.Windows;
using WalletApp.Cards;
using WalletApp.Dashboard;
using WalletApp.Insights;
using WalletApp.Manage;
using WalletApp.ViewModels;
using WalletApp.Views;

namespace WalletApp
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : PrismApplication
    {
        protected override Window CreateShell()
        {
            return Container.Resolve<MainView>();
        }

        protected override void RegisterTypes(IContainerRegistry containerRegistry)
        {
            //containerRegistry.Register<MainViewModel>();
        }

        //protected override void ConfigureViewModelLocator()
        //{
        //    ViewModelLocationProvider.SetDefaultViewTypeToViewModelTypeResolver(viewType =>
        //    {
        //        var viewName = viewType.FullName;
        //        var viewModelName = viewName.Replace(".Views.", ".ViewModels.").Replace("View", "ViewModel");
        //        return Type.GetType(viewModelName);
        //    });
        //}

        protected override void ConfigureModuleCatalog(IModuleCatalog moduleCatalog)
        {
            moduleCatalog.AddModule<DashboardModule>();
            moduleCatalog.AddModule<CardsModule>();
            moduleCatalog.AddModule<InsightsModule>();
            moduleCatalog.AddModule<ManageModule>();
        }
    }

}
