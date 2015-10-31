require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:invalid_project) { FactoryGirl.create(:invalid_project) }
  let(:current_user) { login_with user }
  let(:invalid_user) { login_with nil }

  shared_examples_for 'logged in access to projects' do
    describe "GET #index" do
      it "assigns all projects as @projects" do
        project
        get :index
        # binding.pry
        expect(assigns(:projects)).to eq([project])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "assigns the requested project as @project" do
        project
        get :show, {:id => project.to_param}
        expect(assigns(:project)).to eq(project)
      end

      it "renders the show template" do
        project
        get :show, {:id => project.to_param}
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      it "assigns a new project as @project" do
        get :new
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      it "assigns the requested project as @project" do
        project
        get :edit, {:id => project.to_param}
        expect(assigns(:project)).to eq(project)
      end

      it "renders the edit template" do
        get :edit, {:id => project.to_param}
        expect(response).to render_template(:edit)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, {project: FactoryGirl.attributes_for(:project)}
          }.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          post :create, {project: FactoryGirl.attributes_for(:project)}
          expect(assigns(:project)).to be_a(Project)
          expect(assigns(:project)).to be_persisted
        end

        it "redirects to the created project" do
          post :create, {project: FactoryGirl.attributes_for(:project)}
          expect(response).to redirect_to(Project.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved project as @project" do
          post :create, {project: FactoryGirl.attributes_for(:invalid_project)}
          expect(assigns(:project)).to be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          post :create, {project: FactoryGirl.attributes_for(:invalid_project)}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:project, name: "zibbler", description: "zag nuts") }

        it "updates the requested project" do
          project
          put :update, {:id => project.to_param, :project => new_attributes}
          project.reload
          expect(project.name).to eq("zibbler")
        end

        it "assigns the requested project as @project" do
          project
          put :update, {:id => project.to_param, :project => FactoryGirl.attributes_for(:project) }
          expect(assigns(:project)).to eq(project)
        end

        it "redirects to the project" do
          project
          put :update, {:id => project.to_param, :project => FactoryGirl.attributes_for(:project) }
          expect(response).to redirect_to(project)
        end
      end

      context "with invalid params" do
        it "assigns the project as @project" do
          project
          put :update, {:id => project.to_param, :project => FactoryGirl.attributes_for(:invalid_project)}
          expect(assigns(:project)).to eq(project)
        end

        it "re-renders the 'edit' template" do
          project
          put :update, {:id => project.to_param, :project => FactoryGirl.attributes_for(:invalid_project)}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested project" do
        project
        expect {
          delete :destroy, {:id => project.to_param}
        }.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        project
        delete :destroy, {:id => project.to_param}
        expect(response).to redirect_to(projects_url)
      end
    end
  end #end of user logged in/shared example

  shared_examples_for 'restricted access when not logged in' do
    describe "GET #index" do
      before(:example) do
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
    end

    describe "GET #show" do
      before(:example) do
        project
        get :show, {:id => project.to_param}
      end
        it { is_expected.to redirect_to new_user_session_path }
    end

    describe "GET #new" do
      before(:example) do
        get :new
      end
     it { is_expected.to redirect_to new_user_session_path }
    end

    describe "GET #edit" do
      before(:example) do
        project
        get :edit, {:id => project.to_param}
      end
     it { is_expected.to redirect_to new_user_session_path }
    end

    describe "POST #create" do
      context "with valid params" do
        before(:example) do
          post :create, {project: FactoryGirl.attributes_for(:project)}
        end
        it { is_expected.to redirect_to new_user_session_path }
      end

      context "with invalid params" do
        before(:example) do
          post :create, {project: FactoryGirl.attributes_for(:invalid_project)}
        end
        it { is_expected.to redirect_to new_user_session_path }
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:project, name: "zibbler", description: "zag nuts") }

        before(:example) do
          project
          put :update, {:id => project.to_param, :project => new_attributes}
        end

       it { is_expected.to redirect_to new_user_session_path }
      end

      context "with invalid params" do
        before(:example) do
          project
          put :update, {:id => project.to_param, :project => FactoryGirl.attributes_for(:invalid_project)}
        end
        it { is_expected.to redirect_to new_user_session_path }
      end
    end

    describe "DELETE #destroy" do

      before(:example) do
        project
        delete :destroy, {:id => project.to_param}
      end
     it { is_expected.to redirect_to new_user_session_path }
    end

  end #end of user not logged in/shared example

  describe "user access" do
    before :each do
      current_user
    end

    it_behaves_like 'logged in access to projects'
  end

  describe "user not logged in" do
    before(:each) do
      invalid_user
    end

    it_behaves_like 'restricted access when not logged in'
  end

end #final ender
