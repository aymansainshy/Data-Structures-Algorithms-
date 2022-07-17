class Node {
    constructor(data, next = null) {
        this.data = data;
        this.next = next;
    }
}


class LinkedList {
    constructor() {
        this.head = null;
        this.size = 0;
    }

    // Insert first node push
    insertFirst(data) {
        this.head = new Node(data, this.head);
        this.size++;
    }


    // Insert last node  append
    insertLastNode(data) {
        let node = new Node(data);
        let current;

        // If empty, make head 
        if (!this.head) {
            this.head = node;
        } else {
            current = this.head;

            while (current.next) {
                current = current.next;
            }

            current.next = node;
        }

        this.size++;
    }


    // Insert at index 
    insertAt(data, index) {
        // if index is out of range 
        if (index < 0 && index > this.size) {
            return;
        }

        // if first index 
        if (index === 0) {
            // this.head = new Node(data, this.head);
            this.insertFirst(data);
            return;
        }

        const node = new Node(data);
        let current, previous;

        // Set current to first 
        current = this.head;
        let count = 0;

        while (count < index) {
            previous = current; // Node before index 
            count++;
            current = current.next; // Node after index 
        }

        previous.next = node;
        node.next = current;

        this.size++;
    }

    // Get at index 
    getAt(index) {
        let current = this.head
        let count = 0;

        while (current) {
            if (count == index) {
                console.log(current.data);
                return current;
            }

            count++;
            current = current.next;
        }

        return null;
    }

    // Remove at index
    removeAt(index) {
        if (index < 0 && index > this.size) {
            return;
        }

        let current = this.head;
        let previous;
        let count = 0;

        // Remove first 
        if (index === 0) {
            this.head = current.next;
        } else {
            while (count < index) {
                count++;
                previous = current;
                current = current.next;
            }

        }
        previous = current.next;
    }

    // Clear list 
    clearList() {
        this.head = null;
        this.size = 0;
    }

    // Print list data 
    printListData() {
        let current = this.head;

        while (current) {
            console.log(current.data);
            current = current.next;
        }
    }
}


const n1 = new Node(100);
console.log(n1);