export interface Order {
  id: string;
  productId: string;
  status: "pending";
}

export interface OrderRepository {
  save(order: Order): Promise<void>;
}
