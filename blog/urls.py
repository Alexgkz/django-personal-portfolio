from django.urls import path
# from django.conf.urls.static import static
from . import views

app_name = 'blog'

urlpatterns = [
    path('',views.all_blogs, name='all_blogs'),
    path('<int:blog_id>/', views.detail, name='detail'),  # p.22 автосоздание ссылки для каждого блога
]
