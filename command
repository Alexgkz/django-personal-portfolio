
cd c:\Users\Professional\myDjangoFolder\passwordGenerator-project\
python manage.py runserver




GIT

git init    - в папке проекта, добавл его в git.

После установки:
git config --global user.email johndoe@example.com
git config --global user.name "John Doe"

git status     состояние git
git add -A     копир изменен в обл Stage
git commit -m "our first commit! "      - наш первый commit
git stash       отменяет все измен до последнего Commit`a
git log    список Commit`ов
git checkout + желтый номер в списке Commit`ов.

Для git hub (в хабе есть подсказка для команд)
git remote add origin https://github.com/Alexgkz/НАЗВАНИЕ ПРОекта в хабе.git
branch -M master
git push -u origin master


Новый проект Django

1)django-admin startproject personal_portfolio    создан проекта и папки
2)python manage.py startapp blog    добавл приложен(папку) блог
3)python manage.py startapp portfolio   то же портфолио
4)эти приложения добавляем в список INSTALLED_APPS файла Settings.py основного приложения
5) python manage.py runserver    запуск сервера


6) В models.py добавить Класс и модели класса(виды объектов django field model)
7)pip3 install pillow
8)python manage.py makemigrations   - ввод изменений в модели, (после каждого изменения model)
8.1) python manage.py migrate тоже
9)python manage.py createsuperuser  log:alex pas:klop1234 смена пароля python manage.py changepassword Alex
10)в файл admin.py   добавим какие модели будут доступны из админки (from .models import Project)
