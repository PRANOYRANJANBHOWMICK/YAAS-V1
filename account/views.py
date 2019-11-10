from django.shortcuts import render, redirect
from .forms import *
from django.contrib import messages
from auction.models import Auction, Auction_Status
from .models import *
from django.http import HttpResponseRedirect


def index(request):
    display = Auction.objects.filter(status_id=Auction_Status.objects.get(status="Active").id)
    context = dict()
    context['display'] = display
    if 'language' in request.session:
        userdata = {
            'language': request.session['language'],
        }
    else:
        request.session['language'] = "Eng"
        userdata = {
            'language': "Eng",
        }
    context['data'] = userdata
    if request.method == 'POST':
        display = display.filter(title__icontains=request.POST['Search'])
        context['display'] = display
        if request.POST['language']:
            request.session['language'] = request.POST['language']
            userdata = {
                'language': request.POST['language'],
            }
            context['data'] = userdata
            if 'logged_in' in request.session:
                if request.session['logged_in'] is True:
                    userdata = {
                        'username': request.session['username'],
                        'logged_in': request.session['logged_in'],
                        'language': request.session['language'],
                    }
                    context['data'] = userdata
            return HttpResponseRedirect(request.path_info)
    if 'logged_in' in request.session:
        if request.session['logged_in'] is True:
            userdata = {
                'username': request.session['username'],
                'logged_in': request.session['logged_in'],
                'language': request.session['language'],
            }
            context['data'] = userdata
            return render(request, 'account/home.html', context)
    return render(request, 'account/home.html', context)


def login(request):
    if 'language' in request.session:
        userdata = {
            'language': request.session['language'],
        }
    else:
        request.session['language'] = "Eng"
        userdata = {
            'language': "Eng",
        }
    context = {
        'data': userdata
    }
    if 'logged_in' in request.session:
        if request.session['logged_in'] is True:
            return redirect('account:index')
    return render(request, 'account/login.html', context)


def login_validate(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        try:
            user = User.objects.get(username=username)
        except Exception as ex:
            user = None
        if user is None:
            if request.session['language'] == "Eng":
                messages.error(request, 'Username Mismatched')
            else:
                messages.error(request, 'Käyttäjätunnus Ristiriitaiset')
            return redirect('account:login')
        else:
            if user.password == password:
                request.session['logged_in'] = True
                request.session['username'] = user.username
                request.session['id'] = user.pk
                request.session['language'] = user.language
                return redirect("account:index")
            else:
                if request.session['language'] == "Eng":
                    messages.error(request, 'Wrong Password')
                else:
                    messages.error(request, 'Väärin Salasana')
                return redirect('account:login')
    return render(request, 'account/login.html')


def register(request):
    if 'language' in request.session:
        userdata = {
            'language': request.session['language'],
        }
    else:
        request.session['language'] = "Eng"
        userdata = {
            'language': "Eng",
        }
    context = {
        'data': userdata
    }
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        password_again = request.POST['password-again']
        email = request.POST['email']
        if password != password_again:
            if request.session['language'] == "Eng":
                messages.error(request, 'Password Mismatched. Try Again')
            else:
                messages.error(request, 'Salasana Ristiriitaiset. Yritä Uudelleen')
            return render(request, 'account/register.html')
        try:
            if User.objects.filter(username=username).exists():
                if request.session['language'] == "Eng":
                    messages.error(request, 'That username is already taken.')
                else:
                    messages.error(request, 'Tämä käyttäjätunnus on jo varattu.')
                return render(request, 'account/register.html')
            if User.objects.filter(email=email).exists():
                if request.session['language'] == "Eng":
                    messages.error(request, 'That email id is already taken.')
                else:
                    messages.error(request, 'Tämä sähköpostiosoite on jo otettu.')
                return render(request, 'account/register.html')
            User.objects.create(username=username, password=password, email=email, role=Role.objects.get(id=2), language=request.session['language'])
        except Exception as ex:
            print(ex)
            if request.session['language'] == "Eng":
                messages.error(request, 'Sorry !!! Something Went Wrong.')
            else:
                messages.error(request, 'Anteeksi !!! Jotain Meni Pieleen.')
            return render(request, 'account/register.html')
        return redirect('account:login')
    else:
        return render(request, 'account/register.html', context)


def change_email(request):
    try:
        if 'logged_in' in request.session:
            if request.session['logged_in'] is True:
                userdata = {
                    'username': request.session['username'],
                    'logged_in': request.session['logged_in'],
                    'language': request.session['language'],
                }
                context = {
                    'data': userdata
                }
                if request.method == 'POST':
                    current = request.POST['current']
                    new = request.POST['new']
                    password = request.POST['password']
                    user = User.objects.get(pk=request.session['id'])
                    if user.password == password:
                        if current == user.email:
                            user.email = new
                            user.save()
                            if request.session['language'] == "Eng":
                                messages.success(request, 'Email Updated Successfully')
                            else:
                                messages.success(request, 'Sähköposti Päivitetty')
                            return redirect('account:index')
                        else:
                            if request.session['language'] == "Eng":
                                messages.error(request, 'Email Mismatched')
                            else:
                                messages.error(request, 'Sähköposti Ristiriitaiset')
                            return redirect('account:change_email')
                    else:
                        if request.session['language'] == "Eng":
                            messages.error(request, 'Wrong Password')
                        else:
                            messages.error(request, 'Väärin Salasana')
                        return redirect('account:change_email')
                return render(request, 'account/change_email.html', context)
        else:
            return redirect('account:login')
    except Exception as ex:
        messages.error(request, str(ex))
        return redirect('account:login')


def change_password(request):
    try:
        if 'logged_in' in request.session:
            if request.session['logged_in'] is True:
                userdata = {
                    'username': request.session['username'],
                    'logged_in': request.session['logged_in'],
                    'language': request.session['language'],
                }
                context = {
                    'data': userdata
                }
                if request.method == 'POST':
                    current = request.POST['current']
                    new = request.POST['new']
                    confirm = request.POST['confirm']
                    user = User.objects.get(pk=request.session['id'])
                    if user.password == current:
                        if new == confirm:
                            user.password = new
                            user.save()
                            if request.session['language'] == "Eng":
                                messages.success(request, 'Password Updated Successfully')
                            else:
                                messages.success(request, 'Salasana Päivitetty')
                            return redirect('account:index')
                        else:
                            if request.session['language'] == "Eng":
                                messages.error(request, 'Password Mismatched')
                            else:
                                messages.error(request, 'Salasana Ristiriitaiset')
                            return redirect('account:change_password')
                    else:
                        if request.session['language'] == "Eng":
                            messages.error(request, 'Wrong Password')
                        else:
                            messages.error(request, 'Väärin Salasana')
                        return redirect('account:change_password')
                return render(request, 'account/change_password.html', context)
        else:
            return redirect('account:login')
    except Exception as ex:
        messages.error(request, str(ex))
        return redirect('account:login')


def forgot_password(request):
    return redirect('account:index')


def logout(request):
    del request.session['logged_in']
    return redirect('account:index')
