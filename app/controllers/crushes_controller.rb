class CrushesController < ApplicationController
  def index
    @crush_list = current_user.get_relationships
    tuple_rels ||= []

    @crush_list.each do |pair|
    	first_friend = User.find_by! id: pair[:user_id_one]
    	second_friend = User.find_by! id: pair[:user_id_two]
    	first_f_pic = first_friend.get_profile
        second_f_pic = second_friend.get_profile
    	tuple_rels.push([first_friend, second_friend, first_f_pic, second_f_pic])
    end
    @final_rels = tuple_rels
  end

  def new
    friend_one = User.find_by! uid: params[:friend_one_uid]
    friend_two = User.find_by! uid: params[:friend_two_uid]
    User.create_relationship_with(friend_one, friend_two)
  end

  def create
    render text: params[:crush].inspect
  end
end
