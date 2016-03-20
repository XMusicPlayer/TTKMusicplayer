#include "musicroundanimationlabel.h"

#include <QPainter>

MusicRoundAnimationLabel::MusicRoundAnimationLabel(QWidget *parent)
    : QWidget(parent)
{
    m_rotateAngle = 0;

    m_timer.setInterval(50);
    connect(&m_timer, SIGNAL(timeout()), SLOT(update()));
}

MusicRoundAnimationLabel::~MusicRoundAnimationLabel()
{
    m_timer.stop();
}

void MusicRoundAnimationLabel::setPixmap(const QPixmap &pix)
{
    stop();
}

void MusicRoundAnimationLabel::setInterval(int value)
{
    m_timer.setInterval(value);
}

void MusicRoundAnimationLabel::start()
{
    m_timer.start();
}

void MusicRoundAnimationLabel::stop()
{
    m_timer.stop();
}

void MusicRoundAnimationLabel::paintEvent(QPaintEvent *event)
{
    QWidget::paintEvent(event);
    QPainter painter(this);

    QSize self = size();
    QRect rotatedRect(-self.width()/2, -self.height()/2, self.width(), self.height());
    int cx = self.width() / 2;
    int cy = self.height() / 2;

    if(++m_rotateAngle >= 360)
    {
        m_rotateAngle -= 360;
    }

    painter.save();
    painter.setRenderHints(QPainter::Antialiasing | QPainter::SmoothPixmapTransform);
    painter.translate(cx, cy);
    painter.rotate(m_rotateAngle);
    painter.drawPixmap(rotatedRect, m_pixmap);
    painter.restore();
}
