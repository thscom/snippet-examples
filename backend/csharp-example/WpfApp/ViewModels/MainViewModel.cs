using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MahApps.Metro.IconPacks;
using WpfApp.Models;

namespace WpfApp.ViewModels
{
    public class MainViewModel
    {
        public List<MenuItemModel> MenuList { get; set; } = new List<MenuItemModel>();

        public DelegateCommand<SubItemModel> OpenViewCommand { get; set; }

        private IRegionManager _regionManager { get; set; }

        public MainViewModel(IRegionManager regionManager) 
        {
            _regionManager = regionManager;

            MenuList.Add(new MenuItemModel
            {
                Icon = PackIconFontAwesomeKind.HouseChimneySolid,
                Header = "Home",
                SubMenus = { 
                    new SubItemModel {
                        Name = "Dashboard",
                        TargetView = "DashboardPage"
                    }
                }
            });
            MenuList.Add(new MenuItemModel
            {
                Icon = PackIconFontAwesomeKind.GearSolid,
                Header = "Settings",
                SubMenus = {
                    new SubItemModel {
                        Name = "Settings",
                        TargetView = "DashboardPage"
                    },
                     new SubItemModel {
                        Name = "About",
                        TargetView = "DashboardPage"
                    }
                }
            });

            OpenViewCommand = new DelegateCommand<SubItemModel>(DoOpenView);
        }

        private void DoOpenView(SubItemModel model)
        {
            _regionManager.RequestNavigate("MainRegion", model.TargetView);
        }
    }
}
