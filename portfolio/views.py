from django.shortcuts import render
from .models import Project
from django.http import FileResponse, HttpResponse

def home(request):
    projects = Project.objects.all()
    return render(request, 'portfolio/home.html', {'projects':projects})

def about(request):
    return render(request, 'portfolio/about2.html')

def mycertificate(request):
    with open('portfolio/static/portfolio/2.pdf', 'rb') as pdf:
                response = HttpResponse(pdf.read(), content_type='application/pdf')
                response['Content-Disposition'] = 'inline;filename=filename=some_file.pdf'
    pdf2 = response
    pdf3 = FileResponse(open('portfolio/static/portfolio/3.pdf', 'rb'), content_type='application/pdf')
    return render(request, 'portfolio/mycertificate.html', {'pdf2':pdf2, 'pdf3':pdf3})
