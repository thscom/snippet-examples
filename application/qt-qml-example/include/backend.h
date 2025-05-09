#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend: public QObject
{
    Q_OBJECT

public:
    explicit Backend(QObject *parent = nullptr);
    static Backend* instance()
    {
        if (m_instance == nullptr)
        {
            m_instance = new Backend();
        }
        return m_instance;
    }

    Q_INVOKABLE void receive(const QString &msg);

signals:
    void message(QString msg);

private:
    static Backend *m_instance;
};

class Backend2: public QObject
{
    Q_OBJECT
public:
    explicit Backend2(QObject *parent = nullptr);
    Q_INVOKABLE void receive(const QString &msg);

signals:
    void message(QString msg);
};

#endif // BACKEND_H
