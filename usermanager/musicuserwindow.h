#ifndef MUSICUSERWINDOW_H
#define MUSICUSERWINDOW_H

#include <QStackedWidget>
#include "../core/musiclibexportglobal.h"

class MusicUserDialog;
class MusicUserManager;

namespace Ui {
class MusicUserWindow;
}

class MUSIC_EXPORT MusicUserWindow : public QStackedWidget
{
    Q_OBJECT
public:
    explicit MusicUserWindow(QWidget *parent = 0);
    ~MusicUserWindow();

signals:

public slots:
    void musicUserLogin();
    void userStateChanged(const QString&);
    void musicUserContextLogin();

protected:
    Ui::MusicUserWindow *ui;
    bool connectDatabase();
    bool disConnectDatabase();

    MusicUserManager *m_userManager;

};

#endif // MUSICUSERWINDOW_H