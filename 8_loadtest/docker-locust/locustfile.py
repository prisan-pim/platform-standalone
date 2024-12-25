from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task(1)
    def webapp_api(self):
        self.client.get("/api/webapp")

    @task(2)
    def console_api(self):
        self.client.get("/api/console")
