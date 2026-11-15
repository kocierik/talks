import type { Order, OrderRepository } from "./OrderRepository";

export class InMemoryOrderRepository implements OrderRepository {
  readonly orders: Order[] = [];

  async save(order: Order): Promise<void> {
    this.orders.push(order);
  }
}
