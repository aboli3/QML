#ifndef PERSONLISTMODEL_H
#define PERSONLISTMODEL_H
// C++ Model Class
#include <QAbstractListModel>
#include <QVector>
#include <QString>

class PersonListModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum PersonRoles {
        NameRole = Qt::UserRole + 1,
        AgeRole
    };

    PersonListModel(QObject *parent = nullptr) : QAbstractListModel(parent) {
        // Example data
        m_persons.append({"John", 30});
        m_persons.append({"Jane", 28});
        m_persons.append({"Doe", 35});
    }

    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        Q_UNUSED(parent);
        return m_persons.size();
    }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override {
        if (!index.isValid() || index.row() >= m_persons.size()) {
            return QVariant();
        }

        const auto &person = m_persons[index.row()];

        if (role == NameRole) {
            return person.name;
        } else if (role == AgeRole) {
            return person.age;
        }

        return QVariant();
    }

protected:
    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[NameRole] = "name";
        roles[AgeRole] = "age";
        return roles;
    }

private:
    struct Person {
        QString name;
        int age;
    };

    QVector<Person> m_persons;
};

#endif // PERSONLISTMODEL_H
