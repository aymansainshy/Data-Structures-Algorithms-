class LinkedList {
    constructor() {
        this.head = null;
        this.tail = null;
    }

    append(value) {
        const newNode = { value: value, next: null };

        if (this.tail) {
            this.tail.next = newNode;
        }

        this.tail = newNode;

        if (!this.head) {
            this.head = newNode;
        }
    }

    toArray() {
        const element = [];

        let currentNode = this.head;

        while (currentNode) {
            element.push(currentNode);
            currentNode = currentNode.next;
        }
    }
}
  

