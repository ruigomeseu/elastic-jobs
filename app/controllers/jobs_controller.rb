class JobsController < ApplicationController
  before_action :authenticate_user_signup, only: [:new]

  def index
    @jobs = Job.includes(:tags).order('created_at DESC').all
    render :layout => 'landing'
  end

  def new
    @job = Job.new
    @amount = 2500
  end

  def create
    @amount = 2500

    job = current_user.jobs.new(job_params)

    tags = Array.new

    unless params[:tags].nil?
      params[:tags].each do |tag|
        tags.push Tag.find_or_create_by(name: tag)
      end
    end

    job.tags = tags

    unless job.valid?
      flash[:error] = job.errors.full_messages.join('. ')
      return redirect_to new_job_path
    end

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'ElasticJobs Job Post',
      :currency => 'usd'
    )

    job.save

    flash[:success] = 'Your job was created successfully. It will be live in a few hours.'

    return redirect_to jobs_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to new_job_path
  end

  def show
    @job = Job.includes(:tags).find(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:title, :company_name, :logo, :weekly_hours, :location, :description, :application)
  end

end
