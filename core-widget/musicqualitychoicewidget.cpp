#include "musicqualitychoicewidget.h"
#include "musicuiobject.h"
#include "musicitemdelegate.h"

#include <QMenu>
#include <QWidgetAction>

MusicQualityChoiceTableWidget::MusicQualityChoiceTableWidget(QWidget *parent)
    :MusicAbstractTableWidget(parent)
{
    QHeaderView *headerview = horizontalHeader();
    headerview->resizeSection(0, 60);
    headerview->resizeSection(1, 25);
    headerview->resizeSection(2, 25);

    MusicCheckBoxDelegate *delegate = new MusicCheckBoxDelegate(this);
    setItemDelegateForColumn(2, delegate);
    m_previousClickRow = 0;

    createItems();
    setFixedSize(110, 90);
}

MusicQualityChoiceTableWidget::~MusicQualityChoiceTableWidget()
{
    clear();
}

void MusicQualityChoiceTableWidget::createItems()
{
    setRowCount(3);

    QTableWidgetItem *item = new QTableWidgetItem(tr("ST"));
    item->setTextColor(QColor(50, 50, 50));
    item->setTextAlignment(Qt::AlignCenter);
    setItem(0, 0, item);

                      item = new QTableWidgetItem(tr("HD"));
    item->setTextColor(QColor(50, 50, 50));
    item->setTextAlignment(Qt::AlignCenter);
    setItem(1, 0, item);

                      item = new QTableWidgetItem(tr("SD"));
    item->setTextColor(QColor(50, 50, 50));
    item->setTextAlignment(Qt::AlignCenter);
    setItem(2, 0, item);

                      item = new QTableWidgetItem;
    setItem(0, 1, item);

                      item = new QTableWidgetItem;
    item->setIcon(QIcon(":/image/hdQuality"));
    setItem(1, 1, item);

                      item = new QTableWidgetItem;
    item->setIcon(QIcon(":/image/sdQuality"));
    setItem(2, 1, item);

                      item = new QTableWidgetItem;
    item->setData(Qt::DisplayRole, true);
    setItem(0, 2, item);

                      item = new QTableWidgetItem;
    item->setData(Qt::DisplayRole, false);
    setItem(1, 2, item);

                      item = new QTableWidgetItem;
    item->setData(Qt::DisplayRole, false);
    setItem(2, 2, item);

}

void MusicQualityChoiceTableWidget::listCellClicked(int row, int)
{
    if(m_previousClickRow != -1)
    {
        item(m_previousClickRow, 2)->setData(Qt::DisplayRole, false);
    }
    m_previousClickRow = row;
    item(row, 2)->setData(Qt::DisplayRole, true);
}



MusicQualityChoiceWidget::MusicQualityChoiceWidget(QWidget *parent)
    : QToolButton(parent)
{
    setFixedSize(45, 20);
    initWidget();
}

MusicQualityChoiceWidget::~MusicQualityChoiceWidget()
{

}

void MusicQualityChoiceWidget::initWidget()
{
    QMenu *menu = new QMenu(this);
    menu->setStyleSheet(MusicUIObject::MMenuStyle01);
    QWidgetAction *actionWidget = new QWidgetAction(menu);
    MusicQualityChoiceTableWidget *containWidget = new MusicQualityChoiceTableWidget(menu);

    actionWidget->setDefaultWidget(containWidget);
    menu->addAction(actionWidget);
    setMenu(menu);
    setPopupMode(QToolButton::InstantPopup);
}