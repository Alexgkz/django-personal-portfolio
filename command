
cd c:\Users\Professional\myDjangoFolder\personalPortfolio-project\
python manage.py runserver

git add -A
git commit -m "after p21, lesson 4.8"
git push -u origin master

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
8.1) python manage.py migrate тоже,
9)python manage.py createsuperuser  log:alex pas:klop1234 смена пароля python manage.py changepassword Alex
10)в файл admin.py   добавим какие модели будут доступны из админки (from .models import Project)
10.1)  и admin.site.register(Project)
зашли в админку там появилась папка Projects где можно +add добавлять "проекты" с моделями класса Project
11) добавили 1 экземпляр Progect object(1) через +add, но файл сохранился в /portfolio/image, a мы хотели в папке project/media/Images для этого в settings.py добавим
    MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
12)Если в админке нажать на имя файла для отобр, будет ошибка исправим:
  в файл urls.py добавим
    from django.conf.urls.static import static

  в файл settings.py
    MEDIA_URL = 'media/'

в файл urls.py добавим
      from django.conf import settings
вниз
      urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
13) Chekpoint, before lesson 4.5
14) сайт НЕ ОТОБРАЖАЕТСЯ с домашней страницы, т.к. нет данных прописанных в настройках проекта
надо создать стартовую страницу
15) импортируем все модели в код домашней страницы во view.py
projects = Project.objects.all()
  return render(request, 'portfolio/home.html', {'projects':projects})
16)добавим в home.html {{ projects }} чтобы увидеть содержимое объекта(его __call__
просто убедиться что данные импортировались
чтобы просмотреть весь список сменим двойные фигурн скобки на одинарные с % и пройдем циклом.
{% for project in projects %}
{{ project }}
{% endfor %}
(для доступа из страницы к списку {{ xxx   }}  к словарю {% xxxx %} синтаксис django)
так мы получим вывод имен экземпляров проекта (у нас пока 1: project object(1)
если мы к элементу списка добавим через точку названия модели из .Model, то получим содержимое этого элемента класса
{% for project in projects %}
{{ project.title }}       >  "my first project"
{{ project.description }}  > "This is my Description"
{% endfor %}
17)В итоге с выводом картинки и небольшим форматированием Вывод заголовка, коментария, картинки с размером в пикселях

{% for project in projects %}
<h2>{{ project.title }}</h2>
<p>{{ project.description }}</p>
<img src="{{ project.image.url }}" height=220 width=180>
{% if project.url %}
<a href="{{ project.url }}">Link</a>
{% endif %}

{% endfor %}


если project.url существует то надо отобразить содержимое тега <a>:
{% if project.url %}
<br><a href="{{ project.url }}">Link</a>
{% endif %}
br - возрат коретки

Теперь мы можем через админку добавлять сколько угодно страниц, блогов и т.д.

18) lesson 4.6 можем переходить к другим страницам по названию blog/:
  path('blog/', include('blog.urls')),    - urls.py
  вместо path('',views.home, name='home'),

  надо создать в папке blog файл urls.py:

  from django.urls import path
  from . import views

  urlpatterns = [
      path('',views.all_blogs, name='all_blogs'
  ]

  как делали в personal_portfolio.
  также делаем файл views.py в папке blog для страницы all_blogs:

  from django.shortcuts import render

  def all_blogs(request):
      return render(request, 'blog/all_blogs.html')

  далее делаем файл all_blogs.html аналогично personal_portfolio

  в итоге все запросы включающие(include) "blog/" названии будут искаться в приложении blog и его файле urls.py

19) создаю страницу blogs со списком блогов

20) во views.py добавим .order_by('-data')[:5] вместо .all()

def home(request):
    projects = Project.objects.all()
    return render(request, 'portfolio/home.html', {'projects':projects})
блоги будут отсортированны по дате и будут выведены последние 5 штук

21) добавляем статические файлы котор не могут изменить пользователи из админки
например картинка на заглавной странице home.html
{% load static %}

<img src="{% static 'portfolio/1.jpg' %}">


{% load static %} - обязательно перед любым обращениям к статик файлам, для которых мы сделали папку static/portfolio
папка static прописана в STATIC_URL = 'static/' (setting.py), а путь к файлу:
  portfolio\static\portfolio\1.jpg
  Ссылка на сскачивание файла
  <a href="{% static 'portfolio/2.pdf' %}">Certificate</a>
