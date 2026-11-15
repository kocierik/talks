import { InMemoryOrderRepository } from "./orders/InMemoryOrderRepository";
import { postOrder } from "./routes/postOrder";

async function main() {
  const repository = new InMemoryOrderRepository();
  const response = await postOrder({ productId: "sku-42" }, repository);
  console.log(response);
}

void main();
