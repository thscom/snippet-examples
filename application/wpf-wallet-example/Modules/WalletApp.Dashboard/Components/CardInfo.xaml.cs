using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WalletApp.Dashboard.Components
{
    /// <summary>
    /// CardInfo.xaml 的交互逻辑
    /// </summary>
    public partial class CardInfo : UserControl
    {

        public static readonly DependencyProperty BalanceProperty =
            DependencyProperty.Register("Balance", typeof(Decimal), typeof(CardInfo), new PropertyMetadata(0.0));
        public Decimal Balance { get; set; }

        public CardInfo()
        {
            InitializeComponent();
        }
    }
}
