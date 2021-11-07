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
using Microsoft.Win32;
using System.IO;
using System.Drawing;

namespace DatingSimGenerator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public List<Girl> Girls { get; set; }
        public List<Location> Locations { get; set; }
        public string basePath;


        public MainWindow()
        {
            Girls = new List<Girl>();
            Locations = new List<Location>();


            InitializeComponent();


            locationsListBox.ItemsSource = Locations;
            girlsListBox.ItemsSource = Girls;
        }



        private void loadData() {
            Girls.Clear();
            Locations.Clear();

            if (basePath != "")
            {


                //Loads Locations
                string backgroundFolder = basePath + "backgrounds";
                if (Directory.Exists(backgroundFolder))
                {
                    string[] locationDirectories = Directory.GetDirectories(backgroundFolder);

                    foreach (var item in locationDirectories)
                    {
                        Locations.Add(new Location(item));
                    }
                }
                else {
                    Directory.CreateDirectory(backgroundFolder);
                }



                //Loads girls
                string girlsFolder = basePath + "Assets\\Girls";
                if (Directory.Exists(girlsFolder))
                {
                    string[] locationDirectories = Directory.GetDirectories(girlsFolder);

                    foreach (var item in locationDirectories)
                    {
                        Girls.Add(new Girl(item));
                    }
                }
                else
                {
                    Directory.CreateDirectory(girlsFolder);
                }
                WD.Width = WD.Width + 10;

            }

        }




        private void Button_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();

            if (openFileDialog.ShowDialog() == true) {
                basePath = openFileDialog.FileName.Remove(openFileDialog.FileName.Length - 9);
                txtEditor.Text = basePath;
                loadData();
            }
        }

        private void GirlListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (e.AddedItems.Count != 0)
            {
                clothesBox.ItemsSource = ((Girl)((e.AddedItems)[0])).clothes;
            }
        }


        private void clothesListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (e.AddedItems.Count != 0)
            {
                moodBox.ItemsSource = ((GirlClothes)((e.AddedItems)[0])).moods;
            }


        }

        private void ClothesAdd_Click(object sender, RoutedEventArgs e)
        {


            string name = clothesTB.Text;
            if (name != "") {
                ((Girl)girlsListBox.SelectedItem).addClothes(name);
            }

        }

        private void MoodAdd_Click(object sender, RoutedEventArgs e)
        {
            string name = moodTB.Text;
            if (name != "")
            {
                ((GirlClothes)clothesBox.SelectedItem).addMood(name);
            }
        }

        private void moodBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (e.AddedItems.Count != 0)
            {
                ((GirlClothesMoods)(e.AddedItems[0])).loadData();

                if (((GirlClothesMoods)(e.AddedItems[0])).img != null)
                {
                    image.Source = ((GirlClothesMoods)(e.AddedItems[0])).img;
                    image.Visibility = Visibility.Visible;
                    noImage.Visibility = Visibility.Collapsed;
                }
                else {
                    image.Visibility = Visibility.Collapsed;
                    noImage.Visibility = Visibility.Visible;
                }
            }

        }

        private void newImg_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();

            if (openFileDialog.ShowDialog() == true)
            {
                string newfile = openFileDialog.FileName;
                ((GirlClothesMoods)moodBox.SelectedItem).addImage(newfile);
            }
        }
    }

    public class MasterClass
    {
        public string name { get; set; }
        public string basePath { get; set; }
        public MasterClass(string path)
        {
            string[] splittetPath = path.Split("\\");

            this.name = splittetPath.Last();
            this.basePath = path.Replace(this.name, "");
        }
    }



    public class Location : MasterClass
    {
        public Location(string path) : base(path)
        {
        }
    }


    public class Girl : MasterClass
    {
        public List<GirlClothes> clothes;

        public Girl(string path) : base(path)
        {
            clothes = new List<GirlClothes>();
            
            //Loads clothes
            string clothFolder = basePath + "\\"+ this.name;
            if (Directory.Exists(clothFolder))
            {
                string[] clothesDirectories = Directory.GetDirectories(clothFolder);

                foreach (var item in clothesDirectories)
                {
                    clothes.Add(new GirlClothes(item, name));
                }
            }
            else
            {
                Directory.CreateDirectory(clothFolder);
            }
        }
        
       public void addClothes(string clothesName) {
            string newPath = basePath + "\\" + name + "\\" + clothesName;

            if (!Directory.Exists(newPath)) {
                Directory.CreateDirectory(newPath);
                clothes.Add(new GirlClothes(newPath, name));
            }
        }

    }
    public class GirlClothes : MasterClass
    {
        public List<GirlClothesMoods> moods;
        string parentName;

        public GirlClothes(string path, string parentName) : base(path)
        {
            this.parentName = parentName;


            moods = new List<GirlClothesMoods>();

            //Loads clothes
            string clothFolder = basePath + "\\" + this.name;
            if (Directory.Exists(clothFolder))
            {
                string[] clothesDirectories = Directory.GetDirectories(clothFolder);

                foreach (var item in clothesDirectories)
                {
                    moods.Add(new GirlClothesMoods(item, name));
                }
            }
            else
            {
                Directory.CreateDirectory(clothFolder);
            }

        }
       public void addMood(string clothesName)
        {
            string newPath = basePath + "\\" + name + "\\" + clothesName;

            if (!Directory.Exists(newPath))
            {
                Directory.CreateDirectory(newPath);
                moods.Add(new GirlClothesMoods(newPath, name));

            }
        }
        
    }


    public class GirlClothesMoods : MasterClass
    {
        string parentName;

        public ImageSource img;

        public GirlClothesMoods(string path, string parentName) : base(path)
        {
            this.parentName = parentName;
        }

        public void loadData()
        {
            if (img == null) {
                string imagePath = basePath + "\\" + name + "\\sprite.png";

                if (File.Exists(imagePath))
                {
                    img = new BitmapImage(new Uri(imagePath));
                }
            }
        }

        public void addImage(string filePath) {

            string newFilePath = basePath + "\\" + name + "\\sprite.png";

            File.Copy(filePath, newFilePath, true);
            loadData();
        }
    }
}
