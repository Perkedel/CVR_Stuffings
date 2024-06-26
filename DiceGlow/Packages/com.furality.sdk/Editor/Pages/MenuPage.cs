namespace Furality.SDK.Editor.Pages
{
    public abstract class MenuPage
    {
        protected MainWindow _mainWindow;

        protected MenuPage(MainWindow mainWindow)
        {
            _mainWindow = mainWindow;
        }
        
        public abstract void Draw();

        public abstract void BeforeDraw();
    }
}