import type { Order, OrderRepository } from "./OrderRepository";

export async function createOrder(
  productId: string,
  repository: OrderRepository,
): Promise<Order> {
  const order: Order = {
    id: crypto.randomUUID(),
    productId,
    status: "pending",
  };

  await repository.save(order);
  return order;
}
