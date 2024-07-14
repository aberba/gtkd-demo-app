import std.stdio : writeln;

import gtk.MainWindow;
import gtk.Main;
import gtk.TreeIter;
import gtk.TreeView;
import gtk.Widget;
import gtk.TreeViewColumn;
import gtk.ListStore;
import gtk.CellRendererText;
import gtk.ScrolledWindow;

void main(string[] args)
{
    Main.init(args);

    // Create the main window
    MainWindow window = new MainWindow("Demo App");
    window.addOnDestroy(delegate(Widget w) { Main.quit(); });
    window.setDefaultSize(400, 300);

    // Create a ListStore with two columns (string, string)
    auto store = new MyStore();
    store.setData(col1Value : "Col1", col2Value:
        "Des1");
    store.setData(col1Value : "Col2", col2Value:
        "Des2");
    store.setData("Col2", "Des2");

    // Create a TreeView and set its model to the ListStore
    MyTreeView treeView = new MyTreeView(store);

    // Create and pack the columns
    TreeViewColumn column1 = new TreeViewColumn("Column 1", new CellRendererText(), "text", 0);
    treeView.addColumn(column1);
    TreeViewColumn column2 = new TreeViewColumn("Column 2", new CellRendererText(), "text", 1);
    treeView.addColumn(column2);

    // Add the TreeView to a ScrolledWindow
    ScrolledWindow scrolledWindow = new ScrolledWindow();
    scrolledWindow.add(treeView);

    // Add the ScrolledWindow to the main window
    window.add(scrolledWindow);

    window.showAll();

    Main.run();
}

class MyStore : ListStore
{
    TreeIter treeIter;

public:
    this()
    {
        super([GType.STRING, GType.STRING]);
    }

    void setData(string col1Value, string col2Value)
    {
        treeIter = this.createIter();
        this.setValue(treeIter, 0, col1Value);
        this.setValue(treeIter, 1, col2Value);
    }
}

class MyTreeView : TreeView
{

public:
    this(ListStore store)
    {
        super(store);
    }

    void addColumn(TreeViewColumn column)
    {
        this.appendColumn(column);
    }
}
