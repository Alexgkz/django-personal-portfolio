
cd c:\Users\Professional\myDjangoFolder\passwordGenerator-project\
python manage.py runserver




GIT

git init    - в папке проекта, добавл его в git.

После установки:
git config --global user.email johndoe@example.com
git config --global user.name "John Doe"

git status     состояние git
git add -А     копир изменен в обл Stage
git commit -m "our first commit! "      - наш первый commit
git stash       отменяет все измен до последнего Commit`a
git log    список Commit`ов
git checkout + желтый номер в списке Commit`ов.


Новый проект Django

1)django-admin startproject personal_portfolio    создан проекта и папки
2)python manage.py startapp blog    добавл приложен(папку) блог
3)python manage.py startapp portfolio   то же портфолио
