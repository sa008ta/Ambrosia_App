class LabelsController < ApplicationController
  before_action :require_login
  before_action :require_staff

  def index
    @labels = Label.order(:position, :id)
  end

  def move_up
    label = Label.find(params[:id])
    previous_label = Label.where("position < ?", label.position).order(position: :desc, id: :desc).first

    if previous_label
      Label.transaction do
        label_position = label.position
        label.update!(position: previous_label.position)
        previous_label.update!(position: label_position)
      end
    end

    redirect_to labels_path
  end

  def move_down
    label = Label.find(params[:id])
    next_label = Label.where("position > ?", label.position).order(position: :asc, id: :asc).first

    if next_label
      Label.transaction do
        label_position = label.position
        label.update!(position: next_label.position)
        next_label.update!(position: label_position)
      end
    end

    redirect_to labels_path
  end
end
