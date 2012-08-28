#!/bin/env ruby
# encoding: utf-8

class UsersController < ApplicationController

  skip_filter   :authenticate,    only: []
  skip_filter   :admin,           only: [:index, :edit, :update, :show ]
  skip_filter   :correct_user,    only: [:index, :show, :new, :create]

  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
    @activated_users = User.all #.where(deactivated: false)
    @deactivated_users = User.all #.where(deactivated: false)
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Mitspieler gelöscht."
    redirect_to users_path
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Einstellungen geändert"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def deactivate
    @user = User.find(params[:id])
    if @user.deactivate!
      flash[:success] = "#{@user.name} deaktiviert"
    else
      flash[:error] = "#{@user.name} konnte nicht deaktiviert werden"
    end
    redirect_to users_path
  end
  
  def activate
    @user = User.find(params[:id])
    if @user.activate!
      flash[:success] = "#{@user.name} aktiviert"
    else
      flash[:error] = "#{@user.name} konnte nicht aktiviert werden"
    end
    redirect_to users_path
  end
  
end
