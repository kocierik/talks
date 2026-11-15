import type { OrderRepository } from "../orders/OrderRepository";
import { createOrder } from "../orders/createOrder";

export async function postOrder(
  body: { productId?: string },
  repository: OrderRepository,
) {
  if (!body.productId) {
    return { status: 400, body: { error: "productId required" } };
  }

  const order = await createOrder(body.productId, repository);
  return { status: 201, body: order };
}
