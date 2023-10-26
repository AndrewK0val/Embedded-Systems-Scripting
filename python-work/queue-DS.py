class TaskQueue():
    def __intit__(self):
        self.queue = []
    
    def add_task(self, task):
        self.queue.append(task)

    def is_empty(self):
        return len(self.queue) == 0

    def complete_task():
        if not self.is_empty():
            completed_task = self.queue.pop(0)
            print(f"Completed task: {completed_task}" )
        else:
            print("No tasks to complete!")

    def list_tasks(self):
        if not self.is_empty():
            print("Tasks to be done:")
            for i, task in enumerate(self.queue, 1):
                print(f"{i}, {task}")
            else:
                print("No tasks to display")

def main():
    task_queue = TaskQueue()

    while True:
        print("\nOptions")
        print("1. add task")
        print("2. complete task")
        print("3. list tasks")
        print("4. quit")
    
        choice = input("enter your choice: ")

        if choice == "1":
            task = input("Enter the task")
            task_queue.add_task(task)
            print(f"Task {task} has been added")
        elif choice == 2:
            task_queue.complete_task()
        elif choice == 3:
            task_queue.list_tasks()
        elif choice == 4:
            break

        else: print("Invalid choice ")

if __name__ == "__main__":
    main()
            


            

    

        