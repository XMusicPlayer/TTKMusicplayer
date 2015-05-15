#ifndef MUSICUSERDIALOG_H
#define MUSICUSERDIALOG_H

#include <QDialog>
#include <QMouseEvent>
#include "../core/musicmovedialogabstract.h"

class MusicUserModel;

namespace Ui {
class MusicUserDialog;
}

class MUSIC_EXPORT MusicUserDialog : public MusicMoveDialogAbstract
{
    Q_OBJECT
public:
    explicit MusicUserDialog(QWidget *parent = 0);
    ~MusicUserDialog();

signals:
    void userLoginSuccess(const QString&);

public slots:
    void userLogin();
    void checkUserLogin();
    void registerUser();
    void checkRegisterUser();
    void userForgotPasswd();
    void checkUserForgotPasswd();
    void changeVerificationCode();
    void userComboBoxChanged(QString);
    void checkToAutoLogin();

protected:
    void firstStatckWidget();
    void secondStatckWidget();
    void thirdStatckWidget();
    void clearOriginData();
    void drawRoundedRect();
    void readFromUserConfig();
    void readFromUserSettings();
    void writeToUserConfig();
    void writeToUserSettings();

    Ui::MusicUserDialog *ui;
    MusicUserModel* m_userModel;
    QMap<QString,QStringList> m_parameter;
    QString m_userComboIndex;

};

#endif // MUSICUSERDIALOG_H