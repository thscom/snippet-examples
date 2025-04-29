using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WalletApp.Models;
using MahApps.Metro.IconPacks;
using System.Windows;

namespace WalletApp.ViewModels
{
    public class MainViewModel: BindableBase
    {
        public List<MenuItem> MenuItems { get; set; } = [];

        public DelegateCommand<MenuItem> AsideMenuCommand { get; set; }        
        
        private IRegionManager _regionManager;

        public MainViewModel(IRegionManager regionManager)
        {
            _regionManager = regionManager;
                    
            MenuItems.AddRange([
                new MenuItem
                {
                    Title = "Home",
                    Icon = PackIconFontAwesomeKind.HouseChimneySolid,
                    TargetView = "DashboardView"
                },
                new MenuItem
                {
                    Title = "Cards",
                    Icon = PackIconFontAwesomeKind.CreditCardSolid,
                    TargetView = "CardsView"
                },
                new MenuItem
                {
                    Title = "Insights",
                    Icon = PackIconFontAwesomeKind.CircleInfoSolid,
                    TargetView = "InsightsView"
                },
                new MenuItem
                {
                    Title = "Manage",
                    Icon = PackIconFontAwesomeKind.SlidersSolid,
                    TargetView = "ManageView"
                }
            ]);

            AsideMenuCommand = new DelegateCommand<MenuItem>(DoAsideMenuItemChanged);            
        }

        private void DoAsideMenuItemChanged(MenuItem item)
        {
            //MessageBox.Show($"Selected: {item.Title}");
            _regionManager.RequestNavigate("MainRegion", item.TargetView);
        }
    }
}
