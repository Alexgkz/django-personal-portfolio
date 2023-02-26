
cd c:\Users\Professional\myDjangoFolder\personalPortfolio-project\
python manage.py runserver

git add -A
git commit -m "after p34, lesson 4.12"
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

22) p.4.10 Detail Здесь мы сделаем так чтобы автоматически создавались ссылки на каждый экземпляр блога по его ID.
Для этого urls.py добавляем строку:
        path('<int:blog_id/>',views.detail, name='detail'),
в views.py добавляем функцию:
      def detail(request, blog_id):
          return render(request, 'blog/detail.html', {'id':blog_id})
  создаем файл detail.html для шаблона блога(пока только id):
  {{ id }}
  после этих добавлений пришлось перезапустить сервер
  после всего этого у нас при наборе url=http://127.0.0.1:8000/blog/11/
  выводится страница с цифрой '11' ({{ id }}

23) Для связи со страницей блога делаем следуюющее:
в views.py изменяем функцию detail:
    from django.shortcuts import render, get_object_or_404
      def detail(request, blog_id):
          blog = get_object_or_404(Blog, pk=blog_id)
          return render(request, 'blog/detail.html', {'blog':blog})
изменяем файл detail.html для шаблона блога(пока только заголовок):
          {{ blog.title }}
после всего этого у нас при наборе url=http://127.0.0.1:8000/blog/2/
выводится заголовок блога blog.title, если такого экземпляра(№2) нет то будет ОШИБКА 404 'нет страницы'

24) для того что выводилась страница блога нажатием на заголовок на странице all_blogs
дорабатываем all_blogs.html (href="{% url 'detail' blog.id %}):
<h2><a href="{% url 'detail' blog.id %}" {{ blog.title }}</a></h2>
25) это работает, но не совсем так как надо, если у нас будет несколько приложений
в сайте с применением detailб то надо чтобы джанго их раздичала для этого
в blog/urls.py добавим:
    app_name = 'blog'
  и чтобы не было ошибки в all_blogs.html добавим 'blog:', чтобы джанго знала
  что эту функцию 'detail' искать во views.py приложения app_name = 'blog'
  <h2><a href="{% url 'blog:detail' blog.id %}">{{ blog.title }}</a></h2>
26) lesson 4.11 счетчик блоков в all_blogs.html
<h2>Alex has written {{blogs.count }} blog{{ blogs.count|pluralize }}</h2>
{{ blogs.count|pluralize }} - добавляет букву "s" к словам во множественном числе.
27) перенастройка формата вывода даты
<h5>{{ blog.data|date:'M d Y' }}</h5>
28) ограничение количества (100) выводимых символов не используя срезы
<p>{{ blog.description|safe|truncatechars:100 }}</p>
29) чтобы в тексте работали теги <b></b>, <p></p> и др. добавим |safe до truncatechars
<p>{{ blog.description|safe|truncatechars:100 }}</p>
30)если вместо safe ввести striptags, то теги деактивируются и уберутся из выведенного текста
31)добавили дату в detail.html
<h2>-- {{ blog.data|date:'F jS Y' }} --</h2>
вывод: --February 17th 2023--      #  jS -это буквы th после даты
32) Добавили текст description в detail.
{{ blog.description|safe }}


33) чтобы в админке вместо blog object 1, blog object 2... выводились заголовки блогов
для Blog или заголовки приложений для portfolio добавляем в их model.py в нужный класс:
      def __str__(self):
          return self.title
34) lesson 4.12 улучшение с bootstrap. Добавление строки навигации сверху.
1)Зашли на https://getbootstrap.com/docs/5.3/getting-started/introduction/
скопировали готовый шаблон и поместили свою html страницу в тег Body
2) в Bootstrap в поиске набрали navbar, нашли страницу и скопировали скрипт в body
перед кодом страницы.
3) тоже самое (1-2)можем сделать  для all_blogs, detail.
Но это неудобно, поэтому обычно делают шаблон страницы который редактируется 1 раз для всех страниц.
Создаем файл base.html и копируем туда содержимое home.html. убираем текст тела страницы кроме bootstrap.
и вместо этого тела добавляем {% block content %}{% endblock %}

теперь во всех файлах страниц .html добаляем сначала код:
{% extends 'portfolio/base.html' %}

{% block content %}

и в конце:
{% endblock %}
Это позволит загрузить базовую страницу 'portfolio/base.html' и
вставит то что между тегами {% block content %}  {% endblock %} между этими же тегами
в базовой странице.

Вот теперь выполняем пункт 3 для all_blogs, detail. Все страницы в едином стиле.

35)lesson 4.13. настройка navbar добавка страницы About.
